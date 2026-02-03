## ⚙️ Installation & Setup

### CLI Quick Reference (Ubuntu/Mac)
| Task | Ubuntu Command | Mac (Homebrew) |
| :--- | :--- | :--- |
| **Install** | `sudo apt install postgresql` | `brew install postgresql` |
| **Start Server** | `sudo service postgresql start` | `brew services start postgresql` |
| **Access Shell**| `sudo -u postgres psql` | `psql postgres` |
| **Check Version**| `psql --version` | `psql --version` |

### 🔑 Initial Security Setup
Once inside the `psql` shell, set your password:
```sql
ALTER USER postgres WITH PASSWORD 'secure_password_here';