Major mode for editing systemd units.

Similar to `conf-mode' but with added highlighting; e.g. for
specifiers and booleans.  Employs strict regex for whitespace.
Features a facility for browsing documentation: use C-c C-o to open
links to documentation in a unit (cf. systemctl help).

Supports completion via `company-mode' of directives and sections
in either units or network configuration.  Use the tunable
`systemd-use-company-p' to control enabling of company.
Alternatively, add company to `systemd-mode-hook'.
