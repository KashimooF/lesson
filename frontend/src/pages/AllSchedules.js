import React, { useState, useEffect } from 'react';
import { getAllSchedules } from '../services/api';

const AllSchedules = () => {
  const [schedules, setSchedules] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  // Загружаем всё расписание
  useEffect(() => {
    loadSchedules();
  }, []);

  const loadSchedules = async () => {
    try {
      const response = await getAllSchedules();
      setSchedules(response.data);
    } catch (err) {
      setError('Не удалось загрузить расписание');
    } finally {
      setLoading(false);
    }
  };

  // Дни недели для отображения
  const daysOfWeek = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'];
  
  // Типы недель
  const weekTypes = ['каждую', 'чётная', 'нечётная'];

  if (loading) return <div className="loading">Загрузка...</div>;
  if (error) return <div className="error">{error}</div>;

  return (
    <div className="card">
      <h2>Всё расписание</h2>
      
      {/* Таблица со всем расписанием */}
      <table className="table">
        <thead>
          <tr>
            <th>Группа</th>
            <th>Предмет</th>
            <th>Преподаватель</th>
            <th>День</th>
            <th>Пара</th>
            <th>Неделя</th>
          </tr>
        </thead>
        <tbody>
          {schedules.map(item => (
            <tr key={item.ID}>
              <td>{item.NameGroup}</td>
              <td>{item.NameSubjects}</td>
              <td>{item.FullName}</td>
              <td>{daysOfWeek[item.DaysOfWeek - 1]}</td>
              <td>{item.NumberPar}</td>
              <td>{weekTypes[item.WeekType]}</td>
            </tr>
          ))}
        </tbody>
      </table>
      
      {/* Если расписания нет */}
      {schedules.length === 0 && (
        <p style={{ textAlign: 'center', marginTop: '2rem' }}>Расписание пусто</p>
      )}
    </div>
  );
};

export default AllSchedules;