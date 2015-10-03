require "../spec_helper"

describe Crdoc::Repository do

  describe "exists?" do
    it "returns if repository exists or not" do
      r = Crdoc::Repository.new TEST_CONFIG_PATH
      system("mv #{r.path} #{r.path}-tmp") if Dir.exists?(r.path)

      begin
        r.exists?.should be_false

        Dir.mkdir_p r.path
        r.exists?.should be_true
      ensure
        Dir.rmdir r.path
        system("mv #{r.path}-tmp #{r.path}") if Dir.exists?("#{r.path}-tmp")
      end
    end
  end

  describe "init" do
    it "clones crystal gh-page git repository if it doesn't exist" do
      r = Crdoc::Repository.new TEST_CONFIG_PATH

      r.init
      r.exists?.should be_true
      Dir.exists?("#{r.path}/api").should be_true
      Dir.exists?("#{r.path}/docs").should be_true
    end
  end

  describe "update" do
    it "updates crystal gh-page repository" do
      r = Crdoc::Repository.new TEST_CONFIG_PATH
      if r.exists?
        r.update.should be_true
      else
        r.update.should be_false
      end
    end
  end
end
