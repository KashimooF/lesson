import React, { useState, useEffect } from 'react';
import { getSubjects, createSubject, deleteSubject } from '../services/api';

const Subjects = () => {
  const [subjects, setSubjects] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [showForm, setShowForm] = useState(false);
  const [newSubject, setNewSubject] = useState({ name: '' });

  // Загружаем предметы
  useEffect(() => {
    loadSubjects();
  }, []);

  const loadSubjects = async () => {
    try {
      const response = await getSubjects();
      setSubjects(response.data);
    } catch (err) {
      setError('Не удалось загрузить предметы');
    } finally {
      setLoading(false);
    }
  };

  // Удаление предмета
  const handleDelete = async (id) => {
    if (window.confirm('Удалить предмет?')) {
      try {
        await deleteSubject(id);
        loadSubjects(); // перезагружаем список
      } catch (err) {
        setError('Не удалось удалить предмет');
      }
    }
  };

  // Создание нового предмета
  const handleCreate = async (e) => {
    e.preventDefault();
    try {
      await createSubject(newSubject);
      setShowForm(false);
      setNewSubject({ name: '' });
      loadSubjects(); // перезагружаем список
    } catch (err) {
      setError('Не удалось создать предмет');
    }
  };

  if (loading) return <div className="loading">Загрузка...</div>;
  if (error) return <div className="error">{error}</div>;

  return (
    <div className="card">
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <h2>Предметы</h2>
        <button className="btn" onClick={() => setShowForm(!showForm)}>
          {showForm ? 'Отмена' : '+ Добавить предмет'}
        </button>
      </div>

      {/* Форма создания нового предмета */}
      {showForm && (
        <form onSubmit={handleCreate} style={{ margin: '1rem 0', padding: '1rem', background: '#f8f9fa', borderRadius: '4px' }}>
          <div className="form-group">
            <label>Название предмета:</label>
            <input
              type="text"
              className="form-control"
              value={newSubject.name}
              onChange={(e) => setNewSubject({ name: e.target.value })}
              required
            />
          </div>
          <button type="submit" className="btn">Создать</button>
        </form>
      )}

      {/* Список предметов */}
      <div className="card-grid">
        {subjects.map(subject => (
          <div key={subject.ID} className="card-item">
            <h3>{subject.NameSubjects}</h3>
            <button 
              className="btn btn-danger"
              onClick={() => handleDelete(subject.ID)}
              style={{ marginTop: '0.5rem' }}
            >
              Удалить
            </button>
          </div>
        ))}
      </div>
    </div>
  );
};

export default Subjects;