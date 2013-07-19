dependencies:
	cabal install -fhighlighting pandoc
	cabal install gitit

install:
	mkdir -p $(to)
	cp -f  gitit.cnf $(to)
	cp -f  claferwiki.sh $(to)
	chmod +x $(to)/claferwiki.sh
	cp -f  README.md $(to)
	cp -f  -r .git $(to)
	mkdir -p $(to)/static/img
	cp -f  static/img/logo.png $(to)/static/img
	mkdir -p $(to)/static/css
	cp -f  static/css/custom.css $(to)/static/css/custom.css
	cp -f  static/css/clafer.css $(to)/static/css/clafer.css
	mkdir -p $(to)/plugins
	cp -f  plugins/ClaferCleanup.hs $(to)/plugins
	cp -f  plugins/ClaferReader.hs $(to)/plugins
	cp -f  plugins/ClaferCompiler.hs $(to)/plugins
	cp -f  plugins/ClaferWriter.hs $(to)/plugins
	
update:
	#cp -f  gitit.cnf $(to)
	cp -f  claferwiki.sh $(to)
	cp -f  README.md $(to)
	cp -f  static/img/logo.png $(to)/static/img
	cp -f  static/css/custom.css $(to)/static/css/custom.css
	cp -f  static/css/clafer.css $(to)/static/css/clafer.css
	cp -f  plugins/ClaferCleanup.hs $(to)/plugins
	cp -f  plugins/ClaferReader.hs $(to)/plugins
	cp -f  plugins/ClaferCompiler.hs $(to)/plugins
	cp -f  plugins/ClaferWriter.hs $(to)/plugins