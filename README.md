# Build

docker build -t py-jokes:0.1 .

# Run

docker run --rm -p 8080:8080 --name myapp -e POSTGRES_USER=<user> -e POSTGRES_PASSWORD=<pass> -e POSTGRES_DB=<db> -e DB_HOST=<host> py-jokes:0.1 --debug

# Debug
docker run --rm -ti --entrypoint sh py-jokes:0.1
