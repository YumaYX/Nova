require 'spec_helper'

describe file('/mnt') do
  it { should be_mounted.with( :type => 'cifs' ) }
end

