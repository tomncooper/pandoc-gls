FILTER = pandoc-gls.lua
PANDOC = pandoc --from markdown --to latex --lua-filter $(FILTER)

test:
	@fail=0; tmp=$$(mktemp); \
	for f in tests/*.md; do \
		name=$$(basename $$f .md); \
		golden=tests/golden/$$name.tex; \
		$(PANDOC) $$f > "$$tmp" 2>&1; \
		if diff -q "$$tmp" "$$golden" >/dev/null 2>&1; then \
			echo "PASS: $$name"; \
		else \
			echo "FAIL: $$name"; \
			diff "$$tmp" "$$golden"; \
			fail=1; \
		fi; \
	done; \
	rm -f "$$tmp"; \
	exit $$fail

update-golden:
	@mkdir -p tests/golden
	@for f in tests/*.md; do \
		name=$$(basename $$f .md); \
		$(PANDOC) $$f > tests/golden/$$name.tex; \
		echo "Updated: tests/golden/$$name.tex"; \
	done

.PHONY: test update-golden
