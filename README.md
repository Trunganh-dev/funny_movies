# Funny Movies

Funny Movies is a Ruby on Rails application for managing and viewing comedy movies.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Ensure you have the following installed:

- Ruby 3.0.2
- Rails 7.1.2
- MySQL 8.0
- Redis 6.2

### Installing

- 1. Clone the repository:

  ```bash
  git clone <repository-url>
  cd funny_movies
  Install dependencies:
  ```

  bash

- Sao chép mã

  ```bash
  bundle install
  yarn install
  ```

  bash

- Set up the database:
- Sao chép mã
  `bash
rails db:create
rails db:migrate
    `
  bash

- Start the Redis server (if not already running):
- Sao chép mã

  ````bash
  redis-server
   ```
   bash

  ````

- Start the Rails server:

- Sao chép mã
  ````bash
  rails server
   ```
   bash
  ````

Access the application at http://localhost:3000.

- Running Tests
- Explain how to run the automated tests for this system:
- Sao chép mã

  ````bash
   bundle exec rspec
      ```
   bash

  ````

- Deployment
- Add additional notes about how to deploy this on a live system.

- Built With
  Ruby on Rails - The web framework used
  MySQL - Database management
  Redis - In-memory data structure store
  and other gems specified in the Gemfile
  Contributing
  Please read CONTRIBUTING.md for details on our code of conduct, and the process for submitting pull requests to us.

- Authors
  Trunganh - Initial work - https://github.com/Trunganh-dev

- License
  This project is licensed under the MIT License - see the LICENSE.md file for details.
