SHELL := bash

build-dbgen:
	cd tpch-dbgen; \
	make -f makefile.suite \
	CC="gcc" \
	DATABASE="ORACLE" \
	MACHINE="LINUX" \
	WORKLOAD="TPCH"

dbgen: build-dbgen
	cd tpch-dbgen; \
	./dbgen -s 1 -f

copy_csvs:
	chmod 644 tpch-dbgen/*.tbl # some tables are 777 for some reason
	mkdir -p csvs
	for table in `cd tpch-dbgen; ls *.tbl | sed 's/\.tbl//g'`; do \
	    echo "copying tpch-dbgen/$$table.tbl to csvs/$$table.csv"; \
		cp "tpch-dbgen/$$table.tbl" "csvs/$$table.csv"; \
		sed -i -e 's/|$$//' "csvs/$$table.csv"; \
	done

prepare-pg-data: dbgen copy_csvs
	mdkdir -p postgres-data

clean:
	rm -rf tpch-dbgen/*.tbl
	rm -rf postgres-data
