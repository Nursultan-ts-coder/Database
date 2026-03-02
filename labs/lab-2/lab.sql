\! psql --version
\! psql -h localhost -U nursultanlukmanov -d postgres -c "SELECT current_user, current_database();"
\! psql -h localhost -U nursultanlukmanov -d university -c "SELECT current_user, current_database();"
\l
\du
\c university
\conninfo
