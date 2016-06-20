describe_recipe 'openldap::auth' do
  it 'can bind anonymously' do
    output = %x(/usr/bin/ldapwhoami -x 2>&1)

    # Server may take a bit of time to respond sometimes.
    retries = 10
    until ( /anonymous/ =~ output ) || retries == 0 do
      printf "sleeping for a bit because retries is #{retries}"
      sleep 1
      retries -= 1
    end

    # Last chance at success
    assert_match /anonymous/, output
    assert_equal 0, $?.exitstatus
  end
end
