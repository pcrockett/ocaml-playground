.PHONY: format test

format:
	ocamlformat --inplace *.ml script/*.ml

test:
	./script/test.ml
