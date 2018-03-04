#!/bin/bash

docker run -p 5432:5432 --name stacklike_backend_postgres -e POSTGRES_PASSWORD=postgres -d postgres -c fsync=off -c full_page_writes=off
