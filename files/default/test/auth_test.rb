describe_recipe 'openldap::auth' do
  it 'can bind anonymously' do

    # Server may take a bit of time to respond sometimes.
    retries = 10
    until ( /anonymous/ =~ %x(/usr/bin/ldapwhoami -x 2>&1) ) || retries == 0 do
      sleep 1
      retries -= 1
    end

    # Last chance at success
    assert_match /anonymous/, %x(/usr/bin/ldapwhoami -x 2>&1)
    assert_equal 0, $?.exitstatus
  end
end
