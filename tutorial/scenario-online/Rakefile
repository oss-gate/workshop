require "rabbit/task/slide"

# Edit ./config.yaml to customize meta data

Dir.glob("../{LICENSE,images/**/*.*}") do |shared_file|
  relative_path = shared_file.gsub(/\A\.\.\//, "")
  file relative_path => shared_file do
    mkdir_p(File.dirname(relative_path))
    cp(shared_file, relative_path)
  end
end

spec = nil
Rabbit::Task::Slide.new do |task|
  spec = task.spec
  task.spec.files += ["LICENSE"]
  task.spec.files += Dir.glob("../images/**/*.*").collect do |path|
    path.gsub(/\A\.\.\//, "")
  end
  # task.spec.files -= Dir.glob("private/**/*.*")
  task.spec.add_runtime_dependency("rabbit-theme-clear-code")
end

desc "Tag #{spec.version}"
task :tag do
  sh("git", "tag", "-a", spec.version.to_s, "-m", "Publish #{spec.version}")
  sh("git", "push", "--tags")
end
