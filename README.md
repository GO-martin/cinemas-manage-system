# Cinemas Management System

_"CinemaManagement"_

## Introduction

The cinema management system is an information organization and operational process system within the movie theater environment. It assists cinema managers in optimizing management processes, delivering better customer service, and enhancing business efficiency.

## Description

Below are some descriptions of this application.
Within the system, there will be 2 roles:

- **System Administrator** Manage locations, cinemas, movies, rooms, showtimes, supplies, tickets, users. Draw chart. Realtime notifications, send mail. Search, filter. Manage profile.
  **Customer** View a list of movie. Choose seat and supplies. Manage tickets, profiles.

## Technologies
Architecture diagram:
![Architecture diagram - Final](https://github.com/GO-martin/cinemas-manage-system/assets/144194606/d177f8ed-e765-4c74-9065-4923a52ba035)


To develop the CinemaManagement website, we utilize the following technologies:

    - Rails 7
    - HTML, Tailwind Css, Slim template
    - Stimulus, Jquery
    - Devise, pundit, rolify (Authentication, Authorization)
    - Active Mailer (Send mail)
    - Background Job (Sidekiq)
    - Active Cable (Turbo Stream)
    - pry-rails (Debug)
    - Rspec (Testing)

## Feature

    - [x] All actor: Authentication and Authorization
    - [x] All: Homepage UI
    - [x] Admin:
        + [x] Amin UI
        + [x] Manage cinemas
        + [x] Manage screening rooms, set size
        + [x] Manage movies, showtime, schedule
        + [x] Manage tickets
        + [x] Manage customers
        + [x] Manage supplies
        + [x] Manage emails
        + [x] Dashboards
        + [x] Manage locations
        + [x] Manage profile
        + [x] Manage notifications
        + [x] Realtime (TurboStream)
    - [x] User:
        + [x] User UI
        + [x] User Process
        + [x] Manage Profile

## How to use ?

- **Step 1:** Download source

- **Step 2:** Install ruby and rails environment

  (Tutorial: https://www.tutorialspoint.com/ruby-on-rails/rails-installation.htm)

- **Step 3:** Prepare a stripe account, key

  (Stripe: https://stripe.com/)

- **Step 4:** Prepare postgresql

  - With local: [https://www.postgresql.org/](https://www.postgresql.org/download/)https://www.postgresql.org/download/
  - Or use host

- **Step 5:** Run `bundle install` to install all denpendencies

- **Step 6:** With local database config can config in config/database.yml

- **Step 7:** Delete old credentials and add new file with following content:
  `secret_key_base: ((value))
postgres_host: ((value))
database_name: ((value))
postgres_user: ((value))
postgres_password: ((value))
stripe_publish_key:((value))
stripe_secret_key: ((value))
email_password: ((value))`

- **Step 8:** Create database `rails db:create`

- **Step 9:** Migrate database `rails db:migrate`

- **Step 10:** Run seed file

- **Step 11:** Run `bin/dev`
