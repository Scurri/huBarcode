default: check

build:
	python setup.py build

upload: build
	python setup.py sdist

publish: upload
	# remove development tag
	python setup.py build sdist upload

install: build
	sudo python setup.py install

check:
	# PEP8 scheitert and den QR-code Tabellen.
	pyflakes hubarcode/ean13/ hubarcode/datamatrix/ hubarcode/code128/ hubarcode/qrcode/*.py examples/
	pep8 -r --ignore=E501 hubarcode/ean13/ hubarcode/datamatrix/ hubarcode/code128/ hubarcode/qrcode/*.py examples/
	-pylint --max-line-length=110 -d E1101 hubarcode/ean13/ hubarcode/datamatrix/ hubarcode/code128/ examples/ examples/

testenv:
	pip install 'virtualenv<20.0.0' tox

test:
	PYTHONPATH=.:./hubarcode tox

.PHONY: tox
