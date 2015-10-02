require "../spec_helper"

describe Crdoc::Repository do
  R = Crdoc::Repository::REPO_PATH

  describe "exists?" do
    it "returns if repository exists or not" do
      system("mv #{R} #{R}-tmp") if Dir.exists?(R)

      begin
        Crdoc::Repository.exists?.should be_false

        Dir.mkdir_p R
        Crdoc::Repository.exists?.should be_true
      ensure
        Dir.rmdir R
        system("mv #{R}-tmp #{R}") if Dir.exists?("#{R}-tmp")
      end
    end
  end

  describe "init" do
    it "clones crystal gh-page git repository if it doesn't exist" do
      break if Crdoc::Repository.exists?

      Crdoc::Repository.init
      Crdoc::Repository.exists?.should be_true
      Dir.exists?("#{R}/api").should be_true
      Dir.exists?("#{R}/api").should be_true
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
