require 'spec_helper'

describe cron do
  it { should have_entry('0 * * * * dnf -y update') }
end
