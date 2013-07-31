puts 'capturing most recent db'
puts 'cloning db from heroku'
url = `heroku pgbackups:url`
puts 'curling db locally'
`curl -o latest.dump #{url}`
puts 'restoring your database'
`pg_restore --verbose --clean --no-acl --no-owner -h localhost -d auxotic_dev latest.dump`
