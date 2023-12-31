# frozen_string_literal: true

# Fact: is_pe, pe_version, pe_major_version, pe_minor_version, pe_patch_version
#
# Purpose: Return various facts about the PE state of the system
#
# Resolution: Uses a regex match against puppetversion to determine whether the
#   machine has Puppet Enterprise installed, and what version (overall, major,
#   minor, patch) is installed.
#
# Caveats:
#
# Fact: pe_version
Facter.add('pe_version') do
  setcode do
    found_version = Facter.value('pe_build')

    unless found_version
      puppet_ver = Facter.value('puppetversion')
      unless puppet_ver.nil?
        pe_ver = puppet_ver.match(%r{Puppet Enterprise (\d+\.\d+\.\d+)})
        found_version = pe_ver[1] if pe_ver
      end
    end

    found_version
  end
end

# Fact: is_pe
Facter.add('is_pe') do
  setcode do
    !Facter.value(:pe_version).to_s.empty?
  end
end

# Fact: pe_major_version
Facter.add('pe_major_version') do
  confine is_pe: true
  setcode do
    pe_version = Facter.value(:pe_version)
    pe_version.to_s.split('.')[0] if pe_version
  end
end

# Fact: pe_minor_version
Facter.add('pe_minor_version') do
  confine is_pe: true
  setcode do
    pe_version = Facter.value(:pe_version)
    pe_version.to_s.split('.')[1] if pe_version
  end
end

# Fact: pe_patch_version
Facter.add('pe_patch_version') do
  confine is_pe: true
  setcode do
    pe_version = Facter.value(:pe_version)
    pe_version.to_s.split('.')[2] if pe_version
  end
end
