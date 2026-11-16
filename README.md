# Terroir Bladi

Backend API for a Moroccan terroir marketplace. The project is intended to
connect local cooperatives and producers with customers looking for products
such as argan oil, dates, honey, olive oil, and traditional crafts.

The backend is built with **NestJS**, **TypeScript**, **Prisma**, and
**PostgreSQL**. Arabic is the primary content language in the data model, with
optional French and English translations.

## Features

- User, cooperative, product, category, order, and review data models
- Multilingual fields for users, cooperatives, categories, and products
- Cooperative administration
- Product listing and creation
- Customer creation and lookup by first name
- Product/cooperative relationships and review/order counts
- Validation with `class-validator`
- Global request validation and security headers with `helmet`
- PostgreSQL development database through Docker Compose
- Prisma migrations and SQL seed data

## Technology stack

- Node.js and npm
- NestJS 11
- TypeScript
- Prisma 6
- PostgreSQL 16
- Jest and Supertest
- Docker Compose

## Repository structure

```text
.
├── app/
│   ├── prisma/
│   │   ├── migrations/       # Database migration
│   │   └── schema.prisma     # Prisma data model
│   ├── src/
│   │   ├── admin/            # Users, cooperatives, products, exceptions
│   │   ├── dto/              # Request validation DTOs
│   │   ├── prisma/           # Prisma service/module
│   │   ├── app.module.ts
│   │   └── main.ts
│   ├── sample_data.sql        # Development seed data
│   └── package.json
├── docker-compose.yml         # PostgreSQL service
├── init-database.sh           # Applies SQL migration and seed files
├── launch.sh                  # Legacy local launcher
└── Makefile                   # Docker lifecycle shortcuts
```

## Prerequisites

- Node.js 20 or later
- npm
- Docker and Docker Compose
- `psql` if applying the SQL files from the host

## Configuration

The application expects a `DATABASE_URL` environment variable because Prisma
reads it from `app/prisma/schema.prisma`.

For the PostgreSQL service defined in `docker-compose.yml`, use:

```env
DATABASE_URL="postgresql://user:mypassword@localhost:5432/mydatabase?schema=public"
PORT=3200
```

Create `app/.env` with these values before running Prisma commands or the API.
The `.env` file is ignored by Git and should not contain production
credentials.

## Getting started

### 1. Start PostgreSQL

```bash
docker compose up -d postgres
```

### 2. Install dependencies

```bash
cd app
npm install
```

### 3. Create the database schema

The committed migration can be applied with Prisma:

```bash
npx prisma migrate deploy
```

Alternatively, the SQL migration is available at
`app/prisma/migrations/20251031204111_/migration.sql`.

### 4. Load development data

After the schema exists, load the sample records from the repository root:

```bash
psql "$DATABASE_URL" -f app/sample_data.sql
```

The seed file contains example users, cooperatives, categories, products,
orders, order items, and reviews. Its passwords are placeholders and must not
be used in a real environment.

### 5. Generate Prisma Client and run the API

```bash
cd app
npx prisma generate
npm run start:dev
```

The API listens on [http://localhost:3200](http://localhost:3200) by default.
Set `PORT` to use another port.

## Available npm scripts

Run these commands from `app/`:

| Command | Description |
| --- | --- |
| `npm run start` | Start NestJS |
| `npm run start:dev` | Start in watch mode |
| `npm run start:prod` | Run the compiled application |
| `npm run build` | Compile the application |
| `npm run lint` | Run ESLint and apply fixes |
| `npm run format` | Format TypeScript files |
| `npm run test` | Run unit tests |
| `npm run test:e2e` | Run end-to-end tests |
| `npm run test:cov` | Run tests with coverage |

## API endpoints

All feature controllers currently use the `/api/admin` prefix.

### Cooperatives

| Method | Path | Description |
| --- | --- | --- |
| `GET` | `/api/admin/cooperatives` | Return up to 10 cooperatives |
| `GET` | `/api/admin/cooperatives/:id` | Find a cooperative by its owning user ID |
| `POST` | `/api/admin/cooperatives` | Create a cooperative |
| `PATCH` | `/api/admin/cooperatives/:id` | Update a cooperative |
| `DELETE` | `/api/admin/cooperatives/:id` | Delete a cooperative |

### Products

| Method | Path | Description |
| --- | --- | --- |
| `GET` | `/api/admin/products` | Return up to 15 products with cooperative, category, review, and order-item data |
| `POST` | `/api/admin/products` | Create a product |

Product-by-ID, update, and delete handlers are present as placeholders but are
not implemented yet.

### Users

| Method | Path | Description |
| --- | --- | --- |
| `GET` | `/api/admin/users/:firstName` | Find the first user matching a first name |
| `POST` | `/api/admin/users` | Create a customer user |

The current user service only permits creation when the requested role is
`CUSTOMER`. Authentication, login, password hashing, authorization guards,
and session/token management are not implemented in the current codebase.

### Root endpoint

`GET /` returns the current product listing from the product service.

## Database model

The Prisma schema defines:

- `User` with `SUPER_ADMIN`, `COOPERATIVE`, and `CUSTOMER` roles
- `Cooperative` profiles linked one-to-one with users
- Hierarchical `Category` records
- Multilingual `Product` records with JSON metadata and inventory fields
- `Order` and `OrderItem` records with order status tracking
- `Review` records with one review per user/product pair

Run Prisma Studio to inspect the local database:

```bash
cd app
npx prisma studio
```

## Testing

Run the unit tests:

```bash
cd app
npm test
```

Run the end-to-end tests:

```bash
npm run test:e2e
```

The test files currently include NestJS starter expectations and may need to be
updated as the API implementation evolves.

## Docker and Make targets

The root `Makefile` provides shortcuts for Docker operations:

```bash
make all      # Run the legacy launch script
make ps       # List running containers
make stop     # Stop containers
make df       # Show Docker disk usage
make prune    # Remove unused Docker data
```

`launch.sh` contains machine-specific Windows paths and legacy setup logic. For
portable development, use the explicit Docker, Prisma, and npm commands above.

## Development notes

- The API enables CORS for all origins during development.
- Global validation strips unknown fields, rejects non-whitelisted fields, and
  transforms request payloads.
- `helmet` is enabled for common HTTP security headers.
- Do not use the sample database credentials or placeholder password hashes in
  production.
- Before deploying, add proper authentication, authorization, password
  hashing, secret management, production CORS settings, and complete the
  unfinished product operations.

## License

No project license is currently declared.
