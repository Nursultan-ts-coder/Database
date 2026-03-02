# Word Reader Script

A small utility to extract text from Word files in this workspace.

## Supported formats

- `.docx`: fully supported via `python-docx` (paragraphs + tables).
- `.doc` (legacy): supported on macOS if `textutil` is available; otherwise convert to `.docx` first.

## Install dependency

```bash
pip install python-docx
```

## Usage

```bash
python scripts/read_docx.py /path/to/file.docx
```

Write output to a file:

```bash
python scripts/read_docx.py /path/to/file.docx --out /path/to/output.txt
```

Read legacy `.doc` on macOS (requires `textutil`):

```bash
python scripts/read_docx.py /path/to/file.doc
```

If you hit an error on `.doc`, open it in Microsoft Word or LibreOffice and re-save as `.docx`, then run the script again.
