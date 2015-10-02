require "./spec_helper"

describe Crdoc::App do
  describe "self.run" do
    it "runs subcommand" do
      Crdoc::App.run %w(search)
    end

    it "show usage on --help" do
      Crdoc::App.run %w(--help)
    end
  end
end
