# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{graft}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Patrick Reagan"]
  s.date = %q{2009-03-06}
  s.email = %q{reaganpr@gmail.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc", "Rakefile", "lib/graft", "lib/graft/attribute.rb", "lib/graft/model.rb", "lib/graft/version.rb", "lib/graft.rb", "test/test_helper.rb", "test/unit", "test/unit/attribute_test.rb", "test/unit/model_test.rb", "test/unit/source_test.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://sneaq.net/}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Simple XML to attribute mapping for your Ruby classes}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hpricot>, ["~> 0.6.0"])
      s.add_runtime_dependency(%q<activesupport>, ["~> 2.0"])
    else
      s.add_dependency(%q<hpricot>, ["~> 0.6.0"])
      s.add_dependency(%q<activesupport>, ["~> 2.0"])
    end
  else
    s.add_dependency(%q<hpricot>, ["~> 0.6.0"])
    s.add_dependency(%q<activesupport>, ["~> 2.0"])
  end
end