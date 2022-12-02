ifneq (,$(wildcard ./.env))
    include .env
    export
endif

.Phony: install
install:
	./scripts/install_mdbook.sh

.Phony: serve
serve:
	./bin/deno run --no-lock -A cli.ts --serve

.Phony: build
build:
	./bin/deno run --no-lock -A ./cli.ts

# The following targets are for building the daily epub, or the weekly epub, or send mail.
# If you only want to build the site, you can ignore them.

.Phony: today
today:
	./bin/deno run --no-lock -A ./cli.ts --today 

.Phony: yesterday
yesterday:
	./bin/deno run --no-lock -A ./cli.ts --yesterday

.Phony: yesterdaymail
yesterdaymail:
	./bin/deno run --no-lock -A ./cli.ts --yesterday --mail
.Phony: lastweek
lastweek:
	./bin/deno run --no-lock -A ./cli.ts --lastweek
.Phony: thisweek
thisweek:
	./bin/deno run --no-lock -A ./cli.ts --thisweek
.Phony: servethisweek
servethisweek:
	./bin/deno run --no-lock -A ./cli.ts --serve --thisweek
.Phony: day
day:
	./bin/deno run --no-lock -A ./cli.ts --day=$(day)

.Phony: serveday
serveday:
	./bin/deno run --no-lock -A ./cli.ts --serve --day=$(day)

