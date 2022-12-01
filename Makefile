ifneq (,$(wildcard ./.env))
    include .env
    export
endif

.Phony: install
install:
	./scripts/install_mdbook.sh

.Phony: serve
serve:
	deno run -A cli.ts --serve

.Phony: build
build:
	deno run -A ./cli.ts

.Phony: today
today:
	deno run -A ./cli.ts --today

.Phony: yesterday
yesterday:
	deno run -A ./cli.ts --yesterday

.Phony: yesterdaymail
yesterdaymail:
	deno run -A ./cli.ts --yesterday --mail
.Phony: lastweek
lastweek:
	deno run -A ./cli.ts --lastweek
.Phony: thisweek
thisweek:
	deno run -A ./cli.ts --thisweek
.Phony: servethisweek
servethisweek:
	deno run -A ./cli.ts --serve --thisweek
.Phony: day
day:
	deno run -A ./cli.ts --day=$(day)

.Phony: serveday
serveday:
	deno run -A ./cli.ts --serve --day=$(day)

.Phony: kindle
kindle:
	deno run -A ./cli.ts --today --kindle
