import React, { useState, useEffect } from 'react';
import { getTeachers, getTeacherSubjects, createTeacher } from '../services/api';
import { Link } from 'react-router-dom';

const Teachers = () => {
  const [teachers, setTeachers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [showForm, setShowForm] = useState(false);
  const [newTeacher, setNewTeacher] = useState({ full_name: '' });
  const [selectedTeacher, setSelectedTeacher] = useState(null);
  const [subjects, setSubjects] = useState([]);

  // Загружаем преподавателей
  useEffect(() => {
    loadTeachers();
  }, []);

  const loadTeachers = async () => {
    try {
      const response = await getTeachers();
      setTeachers(response.data);
    } catch (err) {
      setError('Не удалось загрузить преподавателей');
    } finally {
      setLoading(false);
    }
  };

  // Загружаем предметы конкретного преподавателя
  const loadTeacherSubjects = async (id) => {
    try {
      const response = await getTeacherSubjects(id);
      setSubjects(response.data);
    } catch (err) {
      setError('Не удалось загрузить предметы');
    }
  };

  // Клик по преподавателю
  const handleTeacherClick = (teacher) => {
    setSelectedTeacher(teacher);
    loadTeacherSubjects(teacher.ID);
  };

  // Создание нового преподавателя
  const handleCreate = async (e) => {
    e.preventDefault();
    try {
      await createTeacher(newTeacher);
      setShowForm(false);
      setNewTeacher({ full_name: '' });
      loadTeachers();
    } catch (err) {
      setError('Не удалось создать преподавателя');
    }
  };

  if (loading) return <div className="loading">Загрузка...</div>;
  if (error) return <div className="error">{error}</div>;

  return (
    <div className="card">
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <h2>Преподаватели</h2>
        <button className="btn" onClick={() => setShowForm(!showForm)}>
          {showForm ? 'Отмена' : '+ Добавить преподавателя'}
        </button>
      </div>

      {/* Форма создания */}
      {showForm && (
        <form onSubmit={handleCreate} style={{ margin: '1rem 0', padding: '1rem', background: '#f8f9fa', borderRadius: '4px' }}>
          <div className="form-group">
            <label>ФИО преподавателя:</label>
            <input
              type="text"
              className="form-control"
              value={newTeacher.full_name}
              onChange={(e) => setNewTeacher({ full_name: e.target.value })}
              required
            />
          </div>
          <button type="submit" className="btn">Создать</button>
        </form>
      )}

      {/* Две колонки: преподаватели и их предметы */}
      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '2rem' }}>
        {/* Список преподавателей */}
        <div>
          <h3>Список преподавателей</h3>
          <div className="card-grid">
            {teachers.map(teacher => (
              <div 
                key={teacher.ID} 
                className="card-item"
                onClick={() => handleTeacherClick(teacher)}
                style={{ 
                  cursor: 'pointer', 
                  border: selectedTeacher?.ID === teacher.ID ? '2px solid #2c3e50' : '1px solid #eee'
                }}
              >
                <h3>{teacher.FullName}</h3>
                <Link to={`/schedule/teacher/${teacher.ID}`} className="btn" style={{ marginTop: '0.5rem', display: 'inline-block' }}>
                  Расписание
                </Link>
              </div>
            ))}
          </div>
        </div>

        {/* Предметы выбранного преподавателя */}
        <div>
          {selectedTeacher && (
            <>
              <h3>Предметы: {selectedTeacher.FullName}</h3>
              {subjects.length > 0 ? (
                <div className="card-grid">
                  {subjects.map(subject => (
                    <div key={subject.ID} className="card-item">
                      {subject.NameSubjects}
                    </div>
                  ))}
                </div>
              ) : (
                <p>Нет предметов</p>
              )}
            </>
          )}
        </div>
      </div>
    </div>
  );
};

export default Teachers;