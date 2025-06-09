PYTHON := python3
PIP    := pip3

ACTIVATE  := source venv/bin/activate
ANSIBLEPB := LANG=C ansible-playbook -i localhost, -c local

default:
	@cat makefile | grep ^[a-z] | sort | sed 's/^/make /g;s/:.*//g'

all: install local

install:
	$(PYTHON) -m venv venv
	$(ACTIVATE) && $(PIP) install --upgrade pip
	$(ACTIVATE) && $(PIP) install --no-cache-dir ansible selinux

local: install
	$(ACTIVATE) && $(ANSIBLEPB) init.yml

lint: dev
	$(ACTIVATE) && ansible-lint
lintfix: dev
	$(ACTIVATE) && ansible-lint --fix
dev:
	$(ACTIVATE) && $(PIP) install ansible-lint

clean:
	rm -rf venv
	vagrant destroy -f

vagrant:
	-vagrant destroy -f
	-vagrant up --provision
	vagrant destroy -f

