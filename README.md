# 🎓 Student Management System

A modern, feature-rich web application for managing student information and profiles. Built with **Ruby + Sinatra** and **MongoDB**, this system provides an intuitive interface for admin users to manage student data efficiently.

## ✨ Features

### Core Features
- **User Authentication** - Secure login system with session management
- **Student Profiles** - Comprehensive student information management
- **Search & Filter** - Quick search functionality across student database
- **CRUD Operations** - Create, read, update, and delete student records
- **Responsive Design** - Works seamlessly on desktop and mobile devices

### Student Profile Information
- **Basic Info** - Name, Age, Date Added
- **Contact Details** - Email, Mobile Number, Address
- **School Information** - School Name, Grade/Class, GPA/Marks
- **Guardian Details** - Guardian Name, Phone, Address
- **Identification** - NIC Number, Student ID

### Dashboard Features
- **User Profile Dropdown** - Quick access to profile and settings
- **Theme Toggle** - Dark/Light mode support
- **Student Table** - View all students with sortable columns
- **Quick Actions** - View Profile, Edit, Delete buttons
- **Admin Menu** - Dashboard, Add Student, Logout options

## 🛠️ Tech Stack

| Technology | Purpose |
|-----------|---------|
| **Ruby** | Programming Language |
| **Sinatra** | Web Framework |
| **MongoDB** | NoSQL Database |
| **ERB** | Templating Engine |
| **CSS3** | Styling & Animations |

## 📋 Prerequisites

- Ruby 4.0.0 or higher
- MongoDB 7.0 or higher
- Bundler (Ruby package manager)
- macOS/Linux (tested on macOS 25.2.0)

## 🚀 Installation & Setup

### 1. Clone Repository
```bash
git clone <repository-url>
cd student_web
```

### 2. Install Dependencies
```bash
bundle install
```

### 3. Start MongoDB
```bash
# Using Homebrew
brew services start mongodb-community

# Or manually
mongod --dbpath ~/mongo-data
```

### 4. Create Admin User
```bash
ruby create_admin.rb
```
Default credentials:
- **Username:** `admin`
- **Password:** `1234`

### 5. Start the Application
```bash
ruby app.rb
```

The application will be available at: `http://localhost:4567`

## 📁 Project Structure

```
student_web/
├── app.rb                 # Main Sinatra application
├── create_admin.rb        # Admin user creation script
├── Gemfile               # Ruby dependencies
├── models/
│   ├── student.rb        # Student model with CRUD methods
│   └── user.rb           # User authentication model
├── views/
│   ├── layout.erb        # Main layout template
│   ├── login.erb         # Login page
│   ├── index.erb         # Student list dashboard
│   ├── profile.erb       # Student profile view
│   ├── new.erb           # Add new student form
│   └── edit.erb          # Edit student form
└── public/
    ├── dashboard.css     # Dashboard & general styles
    ├── forms.css         # Form styling
    ├── auth.css          # Authentication page styles
    └── style.css         # Global styles
```

## 🔐 Authentication Flow

1. User visits `/` → Redirected to `/login`
2. Enter credentials (admin/1234)
3. Session created with username stored
4. Access to all protected routes
5. Logout clears session

## 📊 Database Schema

### Students Collection
```javascript
{
  _id: ObjectId,
  name: String,
  age: Number,
  email: String,
  mobile: String,
  address: String,
  school: String,
  grade: String,
  gpa: Number,
  guardian: String,
  guardian_phone: String,
  guardian_address: String,
  nic: String,
  created_at: Date
}
```

### Users Collection
```javascript
{
  _id: ObjectId,
  username: String,
  password: String  // Currently plaintext - use bcrypt in production
}
```

## 🎯 API Routes

### Authentication
- `GET /login` - Display login form
- `POST /login` - Authenticate user
- `GET /logout` - Clear session and logout

### Students Management
- `GET /` - View all students
- `GET /search?q=keyword` - Search students
- `GET /new` - Display add student form
- `POST /create` - Add new student
- `GET /student/:id` - View student profile
- `GET /edit/:id` - Display edit form
- `POST /update/:id` - Update student info
- `GET /delete/:id` - Delete student

## 🎨 UI Features

### Header Navigation
- Logo & App Title
- Theme Toggle (Dark/Light Mode)
- User Profile Dropdown with:
  - User Avatar
  - Username & Role Badge
  - Quick Action Links
  - Logout Button

### Dark Mode
- Enabled by default
- Smooth transitions between themes
- Persistent storage using localStorage

### Responsive Design
- Mobile-optimized layouts
- Touch-friendly buttons and inputs
- Adaptive navigation

## ⚙️ Configuration

### Database Connection
Edit `app.rb` to change MongoDB connection:
```ruby
DB = Mongo::Client.new(['127.0.0.1:27017'], database: 'student_web')
```

### Default Port
Application runs on port **4567**. To change:
```ruby
set :port, 5000  # In app.rb
```

### Session Secret
Change the session secret for production:
```ruby
secret: 'your-production-secret-key'  # In app.rb
```

## 🔐 Security Notes

⚠️ **Important:** This application stores passwords in plaintext. For production use:

1. **Hash Passwords** - Use `bcrypt` gem
```ruby
gem 'bcrypt', '~> 3.1.7'
```

2. **Enable CSRF Protection** - Add Rack::Protection

3. **Input Validation** - Validate all user inputs

4. **HTTPS Only** - Use SSL/TLS in production

## 🐛 Troubleshooting

### MongoDB Connection Error
```
Mongo::Error::NoServerAvailable: connect ECONNREFUSED 127.0.0.1:27017
```
**Solution:** Start MongoDB service
```bash
brew services start mongodb-community
# or
mongod --dbpath ~/mongo-data
```

### Port Already in Use
```
Address already in use - bind(2) for 127.0.0.1:4567
```
**Solution:** Kill the process using the port
```bash
lsof -i :4567 | grep LISTEN | awk '{print $2}' | xargs kill -9
```

### Socket Permission Error
```
Failed to unlink socket file: Permission denied
```
**Solution:** Remove the socket file
```bash
sudo rm -f /tmp/mongodb-27017.sock
```

## 📈 Future Enhancements

- [ ] Quick stats dashboard with student count & analytics
- [ ] Bulk student import (CSV)
- [ ] Student attendance tracking
- [ ] Grade management and reports
- [ ] Email notifications
- [ ] Two-factor authentication
- [ ] Role-based access control
- [ ] Audit logging
- [ ] Data backup & export

## 📝 License

This project is open source and available under the MIT License.

## 👨‍💻 Author

**Nipul Kanishka**
- GitHub: [@nipulkanishka](https://github.com/nipulkanishka)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📧 Support

For issues, questions, or suggestions, please open an GitHub Issue.

---

**Last Updated:** February 24, 2026
**Version:** 1.0.0
