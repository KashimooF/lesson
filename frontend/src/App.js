import React from 'react';
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import './App.css';

// Импортируем страницы (создадим позже)
import Groups from './pages/Groups';
import Teachers from './pages/Teachers';
import Subjects from './pages/Subjects';
import AllSchedules from './pages/AllSchedules';
import GroupSchedule from './pages/GroupSchedule';
import TeacherSchedule from './pages/TeacherSchedule';

function App() {
  return (
    <Router>
      <div className="App">
        {/* Навигация */}
        <nav className="navbar">
          <h1 className="logo">📚 Расписание колледжа</h1>
          <ul className="nav-links">
            <li><Link to="/">Группы</Link></li>
            <li><Link to="/teachers">Преподаватели</Link></li>
            <li><Link to="/subjects">Предметы</Link></li>
            <li><Link to="/schedule/all">Всё расписание</Link></li>
          </ul>
        </nav>

        {/* Контент */}
        <div className="container">
          <Routes>
            <Route path="/" element={<Groups />} />
            <Route path="/teachers" element={<Teachers />} />
            <Route path="/subjects" element={<Subjects />} />
            <Route path="/schedule/all" element={<AllSchedules />} />
            <Route path="/schedule/group/:name" element={<GroupSchedule />} />
            <Route path="/schedule/teacher/:id" element={<TeacherSchedule />} />
          </Routes>
        </div>
      </div>
    </Router>
  );
}

export default App;