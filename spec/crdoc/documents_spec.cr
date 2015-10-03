require "../spec_helper"

describe Crdoc::Documents do
  r = Crdoc::Repository.new "#{__DIR__}/test_config"
  d = Crdoc::Documents.new("#{__DIR__}/test_config", r)

  describe "cache!" do
    it "make a cache" do
      c = d.cache!
      d.cached?.should be_true
      c[:api]?.should_not be_nil
      c[:syntax_and_semantics]?.should_not be_nil
      c[:api].size.should_not eq(0)
      c[:syntax_and_semantics].size.should_not eq(0)
    end
  end

  describe "delete_cache" do
    it "deletes cache if exist" do
      d.cache! unless d.cached?
      d.delete_cache
      d.cached?.should be_false
    end

    it "does nothing if cache does not exist" do
      d.delete_cache if d.cached?
      d.delete_cache
      d.cached?.should be_false
    end
  end

  describe "cache" do
    it "makes a cache if not exist" do
      d.delete_cache if d.cached?
      c = d.cache
      d.cached?.should be_true
      c[:api]?.should_not be_nil
      c[:syntax_and_semantics]?.should_not be_nil
      c[:api].size.should_not eq(0)
      c[:syntax_and_semantics].size.should_not eq(0)
    end

    it "loads cache if it is available" do
      d.cache! unless d.cached?
      c = d.cache
      d.cached?.should be_true
      c[:api]?.should_not be_nil
      c[:syntax_and_semantics]?.should_not be_nil
      c[:api].size.should_not eq(0)
      c[:syntax_and_semantics].size.should_not eq(0)
    end
  end

  describe "list" do
    it "returns list of API candidates if :api is specified" do
      la = d.list :api
      la.size.should_not eq(0)
    end

    it "returns list of language spec candidates if :syntax_and_semantics is specified" do
      lss = d.list :syntax_and_semantics
      lss.size.should_not eq(0)
    end

    it "returns list of all candidates if nothing specified" do
      la = d.list :api
      lss = d.list :syntax_and_semantics
      ll = d.list

      ll.size.should eq(la.size + lss.size)
    end
  end
end
