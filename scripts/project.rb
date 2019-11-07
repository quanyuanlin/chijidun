#!/usr/bin/env ruby
require 'pathname'
require 'Xcodeproj'
require 'yaml'
require 'pp'

class Project
  def run(conf)
    config = YAML::load(File.open(conf))

    project_name=config['name']
    project_file='../'+project_name+'.xcodeproj'

    dir=config['source']
    @src_root=Pathname.new(dir+'/../').realdirpath.to_s
    dir= Pathname.new(dir).realdirpath.to_s+'/'

    Xcodeproj::Project.new(project_file).save
    project=Xcodeproj::Project.open(project_file)
    @target = project.new_target(:application, project_name, :ios)

    group=project.main_group.new_group('source', dir)
    @source_files=Array.new
    @resource_files=Array.new

    @framework_search_paths=['$(inherited)']
    @library_search_paths=['$(inherited)']
    build_file_tree(dir, group)

    #添加target配置信息
    default_config={
        'FRAMEWORK_SEARCH_PATHS' => @framework_search_paths,
        'LIBRARY_SEARCH_PATHS' => @library_search_paths,
        'ASSETCATALOG_COMPILER_LAUNCHIMAGE_NAME' => "LaunchImage",
        'IPHONEOS_DEPLOYMENT_TARGET' => "6.0",
        'ALWAYS_SEARCH_USER_PATHS' => "YES",
        "CLANG_CXX_LANGUAGE_STANDARD" => "gnu++0x",
        "CLANG_CXX_LIBRARY" => "libc++",
        "CLANG_ENABLE_MODULES" => "YES",
        "CLANG_ENABLE_OBJC_ARC" => "YES",
        "CLANG_WARN_BOOL_CONVERSION" => "YES",
        "CLANG_WARN_CONSTANT_CONVERSION" => "YES",
        "CLANG_WARN_DIRECT_OBJC_ISA_USAGE" => "YES_ERROR",
        "CLANG_WARN_UNREACHABLE_CODE" => "YES",
        "CLANG_WARN__DUPLICATE_METHOD_MATCH" => "YES",
        "COPY_PHASE_STRIP" => "NO",
        "ENABLE_STRICT_OBJC_MSGSEND" => "YES",
        "GCC_C_LANGUAGE_STANDARD" => "gnu99",
        "GCC_DYNAMIC_NO_PIC" => "NO",
        "GCC_OPTIMIZATION_LEVEL" => 0,
        "GCC_SYMBOLS_PRIVATE_EXTERN" => "NO",
        "GCC_WARN_64_TO_32_BIT_CONVERSION" => "YES",
        "GCC_WARN_ABOUT_RETURN_TYPE" => "YES_ERROR",
        "GCC_WARN_UNDECLARED_SELECTOR" => "YES",
        "GCC_WARN_UNINITIALIZED_AUTOS" => "YES_AGGRESSIVE",
        "GCC_WARN_UNUSED_FUNCTION" => "YES",
        "MTL_ENABLE_DEBUG_INFO" => "YES",
        "ONLY_ACTIVE_ARCH" => "YES",
        "SDKROOT" => "iphoneos",
        "TARGETED_DEVICE_FAMILY" => "1",
        "GCC_PRECOMPILE_PREFIX_HEADER" => "YES",
        "ENABLE_BITCODE"=>"NO",
    }
    res=default_config.merge config['buildConfiguration']
    res.each_key { |i|
      @target.build_configuration_list.set_setting(i, res[i])
    }
    @target.add_file_references(@source_files)
    @target.add_resources(@resource_files)

    system_frameworks=config['dependencies']['framework'].sort
    for i in system_frameworks
      @target.add_system_framework(i)
    end

    system_dylib=config['dependencies']['dylib'].sort
    for i in system_dylib
      @target.add_system_library(i)
    end
    project.save
  end

  def build_file_tree(dir, group)
    Dir.entries(dir).each { |i|
      extname=File.extname(dir+i)
      if %w(. .. Contents.json .DS_Store .gitignore .svn .git readme.txt).include?(i)
        next
      end
      if %w(.xcassets .xcdatamodeld .bundle).include?(extname)
        @resource_files.push(group.new_reference(i))
        next
      end

      if %w(.framework .a).include?(extname)
        _dir=File.dirname(dir+i)
        _path='$(SRCROOT)'+_dir[@src_root.length, _dir.length-1]

        if extname=='.framework'
          unless @framework_search_paths.include?(_path)
            @framework_search_paths.push(_path)
          end
        else
          unless @library_search_paths.include?(_path)
            @library_search_paths.push(_path)
          end
        end
        @target.frameworks_build_phase.add_file_reference(group.new_file(dir+i), true)
        next
      end

      case File.ftype(dir+i)
        when 'file'
          ref=group.new_reference(i)
          if %w( .h .m .c .mm .cpp .cxx .swift ).include?(extname)
            @source_files.push(ref)
          else
            @resource_files.push(ref)
          end
        when 'directory'
          sub_group=group.new_group(i, dir+i+'/', :group)
          build_file_tree(dir+i+'/', sub_group)
        else
      end
    }
  end

  def create_workspace
    workspace_path=Pathname.new('../chijidun.xcworkspace')

    all_projects = %w( ../chijidun.xcodeproj ../projects/XZFramework.xcodeproj )
    file_references = all_projects.map do |path|
      relative_path =Pathname.new(path).relative_path_from(workspace_path.dirname).to_s
      Xcodeproj::Workspace::FileReference.new(relative_path, 'group')
    end

    if workspace_path.exist?
      workspace = Xcodeproj::Workspace.new_from_xcworkspace(workspace_path)
      new_file_references = file_references - workspace.file_references
      unless new_file_references.empty?
        workspace.file_references.concat(new_file_references)
        workspace.save_as(workspace_path)
      end
    else
      workspace = Xcodeproj::Workspace.new(*file_references)
      workspace.save_as(workspace_path)
    end
  end
end

Project.new.run(ARGV.length==0 ? './project.config.yaml' : ARGV[0])