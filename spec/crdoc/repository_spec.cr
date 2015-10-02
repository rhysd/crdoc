require "../spec_helper"

describe Crdoc::Repository do
  r = Crdoc::Repository::REPO_PATH

  describe "exists?" do
    it "returns if repository exists or not" do
      system("mv #{r} #{r}-tmp") if Dir.exists?(r)

      begin
        Crdoc::Repository.exists?.should be_false

        Dir.mkdir_p r
        Crdoc::Repository.exists?.should be_true
      ensure
        Dir.rmdir r
        system("mv #{r}-tmp #{r}") if Dir.exists?("#{r}-tmp")
      end
    end
  end

  describe "init" do
    it "clones crystal gh-page git repository if it doesn't exist" do
      break if Crdoc::Repository.exists?

      Crdoc::Repository.init
      Crdoc::Repository.exists?.should be_true
      Dir.exists?("#{r}/api").should be_true
      Dir.exists?("#{r}/api").should be_true
    end
  end

  describe "update" do
    it "updates crystal gh-page repository" do
      if Crdoc::Repository.exists?
        Crdoc::Repository.update.should be_true
      else
        Crdoc::Repository.update.should be_false
      end
    end
  end
end
