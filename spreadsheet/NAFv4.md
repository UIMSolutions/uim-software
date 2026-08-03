# NAFv4 Notes

This module follows the repository’s service pattern and uses a layered architecture aligned with NAFv4 terminology:

- Domain: spreadsheet entities and repository contracts.
- Application: use cases exposed through the spreadsheet service.
- Infrastructure: persistence adapters and configuration.
- Presentation: REST controllers and supporting web assets.

The structure is intended to be extended with additional domain entities such as dashboards, datasets, views, and permissions.
