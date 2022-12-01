ifneq (,$(wildcard ./.env))
    include .env
    export
endif

.Phony: install
install:
	./scripts/install_mdbook.sh

.Phony: serve
serve:
	./bin/deno run -A cli.ts --serve

.Phony: build
build:
	./bin/deno run -A ./cli.ts

.Phony: today
today:
	./bin/deno run -A ./cli.ts --today

.Phony: yesterday
yesterday:
	./bin/deno run -A ./cli.ts --yesterday

.Phony: yesterdaymail
yesterdaymail:
	./bin/deno run -A ./cli.ts --yesterday --mail
.Phony: lastweek
lastweek:
	./bin/deno run -A ./cli.ts --lastweek
.Phony: thisweek
thisweek:
	./bin/deno run -A ./cli.ts --thisweek
.Phony: servethisweek
servethisweek:
	./bin/deno run -A ./cli.ts --serve --thisweek
.Phony: day
day:
	./bin/deno run -A ./cli.ts --day=$(day)

.Phony: serveday
serveday:
	./bin/deno run -A ./cli.ts --serve --day=$(day)

.Phony: kindle
kindle:
	./bin/deno run -A ./cli.ts --today --kindle
