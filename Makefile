dependencies:
	cabal update
	cabal install -fhighlighting pandoc
	cabal install gitit

install:
	mkdir -p $(to)
	cp -f --preserve=all gitit.cnf $(to)
	cp -f --preserve=all claferwiki.sh $(to)
	chmod +x $(to)/claferwiki.sh
	cp -f --preserve=all README.md $(to)
	cp -f --preserve=all -r .git $(to)
	mkdir -p $(to)/static/img
	cp -f --preserve=all static/img/logo.png $(to)/static/img
	mkdir -p $(to)/static/css
	cp -f --preserve=all static/css/custom.css $(to)/static/css/custom.css
	cp -f --preserve=all static/css/clafer.css $(to)/static/css/clafer.css
	mkdir -p $(to)/plugins
	cp -f --preserve=all plugins/ClaferCleanup.hs $(to)/plugins
	cp -f --preserve=all plugins/ClaferReader.hs $(to)/plugins
	cp -f --preserve=all plugins/ClaferCompiler.hs $(to)/plugins
	cp -f --preserve=all plugins/ClaferWriter.hs $(to)/plugins
	
update:
	cp -f --preserve=all gitit.cnf $(to)
	cp -f --preserve=all claferwiki.sh $(to)
	cp -f --preserve=all README.md $(to)
	cp -f --preserve=all static/img/logo.png $(to)/static/img
	cp -f --preserve=all static/css/custom.css $(to)/static/css/custom.css
	cp -f --preserve=all static/css/clafer.css $(to)/static/css/clafer.css
	cp -f --preserve=all plugins/ClaferCleanup.hs $(to)/plugins
	cp -f --preserve=all plugins/ClaferReader.hs $(to)/plugins
	cp -f --preserve=all plugins/ClaferCompiler.hs $(to)/plugins
	cp -f --preserve=all plugins/ClaferWriter.hs $(to)/plugins