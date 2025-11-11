
package licenses

default allow = false

allow {
  not deny[_]
}

# Example deny rule for GPL-3.0-only
deny[msg] {
  some i
  input.packages[i].license == lic
  lic == "GPL-3.0-only"
  msg := sprintf("Disallowed license found: %s", [lic])
}
