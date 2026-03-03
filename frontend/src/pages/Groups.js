import React, { useState, useEffect } from 'react';
import { getGroups, deleteGroup, createGroup } from '../services/api';

const Groups = () => {
  const [groups, setGroups] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [showForm, setShowForm] = useState(false);
  const [newGroup, setNewGroup] = useState({ name: '', course: 1 });

  // Загружаем группы при монтировании компонента
  useEffect(() => {
    loadGroups();
  }, []);

  // Функция загрузки групп
  const loadGroups = async () => {
    try {
      const response = await getGroups();
      setGroups(response.data);
    } catch (err) {
      setError('Не удалось загрузить группы');
    } finally {
      setLoading(false);
    }
  };

  // Удаление группы
  const handleDelete = async (id) => {
    if (window.confirm('Удалить группу?')) {
      try {
        await deleteGroup(id);
        loadGroups(); // перезагружаем список
      } catch (err) {
        setError('Не удалось удалить группу');
      }
    }
  };

  // Создание новой группы
  const handleCreate = async (e) => {
    e.preventDefault();
    try {
      await createGroup(newGroup);
      setShowForm(false);
      setNewGroup({ name: '', course: 1 });
      loadGroups(); // перезагружаем список
    } catch (err) {
      setError('Не удалось создать группу');
    }
  };

  if (loading) return <div className="loading">Загрузка...</div>;
  if (error) return <div className="error">{error}</div>;

  return (
    <div className="card">
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <h2>Группы</h2>
        <button className="btn" onClick={() => setShowForm(!showForm)}>
          {showForm ? 'Отмена' : '+ Добавить группу'}
        </button>
      </div>

      {/* Форма создания новой группы */}
      {showForm && (
        <form onSubmit={handleCreate} style={{ margin: '1rem 0', padding: '1rem', background: '#f8f9fa', borderRadius: '4px' }}>
          <div className="form-group">
            <label>Название группы:</label>
            <input
              type="text"
              className="form-control"
              value={newGroup.name}
              onChange={(e) => setNewGroup({ ...newGroup, name: e.target.value })}
              required
            />
          </div>
          <div className="form-group">
            <label>Курс:</label>
            <select
              className="form-control"
              value={newGroup.course}
              onChange={(e) => setNewGroup({ ...newGroup, course: parseInt(e.target.value) })}
            >
              <option value="1">1 курс</option>
              <option value="2">2 курс</option>
              <option value="3">3 курс</option>
            </select>
          </div>
          <button type="submit" className="btn">Создать</button>
        </form>
      )}

      {/* Список групп */}
      <div className="card-grid">
        {groups.map(group => (
          <div key={group.ID} className="card-item">
            <h3>{group.NameGroup}</h3>
            <p>Курс: {group.Course}</p>
            <button 
              className="btn btn-danger"
              onClick={() => handleDelete(group.ID)}
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

export default Groups;