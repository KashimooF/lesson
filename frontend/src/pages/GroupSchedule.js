import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { getGroupSchedule } from '../services/api';

const GroupSchedule = () => {
  const { name } = useParams(); // Получаем название группы из URL
  const [schedule, setSchedule] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [weekType, setWeekType] = useState('all');

  // Загружаем расписание при изменении группы или типа недели
  useEffect(() => {
    loadSchedule();
  }, [name, weekType]);

  const loadSchedule = async () => {
    try {
      const response = await getGroupSchedule(name, weekType);
      setSchedule(response.data);
    } catch (err) {
      setError('Не удалось загрузить расписание');
    } finally {
      setLoading(false);
    }
  };

  // Дни недели для отображения
  const daysOfWeek = ['Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота'];
  
  // Типы недель
  const weekTypes = ['каждую', 'чётная', 'нечётная'];

  // Группировка расписания по дням
  const scheduleByDay = {};
  daysOfWeek.forEach((day, index) => {
    scheduleByDay[day] = schedule.filter(item => item.DaysOfWeek === index + 1);
  });

  if (loading) return <div className="loading">Загрузка...</div>;
  if (error) return <div className="error">{error}</div>;

  return (
    <div className="card">
      <h2>Расписание группы {name}</h2>
      
      {/* Фильтр по типу недели */}
      <div className="filters">
        <label>Тип недели:</label>
        <select className="select" value={weekType} onChange={(e) => setWeekType(e.target.value)}>
          <option value="all">Все недели</option>
          <option value="even">Чётная</option>
          <option value="odd">Нечётная</option>
        </select>
      </div>

      {/* Отображение расписания по дням */}
      {daysOfWeek.map(day => (
        <div key={day} style={{ marginBottom: '2rem' }}>
          <h3>{day}</h3>
          {scheduleByDay[day].length > 0 ? (
            <table className="table">
              <thead>
                <tr>
                  <th>Пара</th>
                  <th>Предмет</th>
                  <th>Преподаватель</th>
                  <th>Тип недели</th>
                </tr>
              </thead>
              <tbody>
                {scheduleByDay[day]
                  .sort((a, b) => a.NumberPar - b.NumberPar)
                  .map(item => (
                    <tr key={item.ID}>
                      <td>{item.NumberPar}</td>
                      <td>{item.NameSubjects}</td>
                      <td>{item.FullName}</td>
                      <td>{weekTypes[item.WeekType]}</td>
                    </tr>
                  ))}
              </tbody>
            </table>
          ) : (
            <p>Нет занятий</p>
          )}
        </div>
      ))}
    </div>
  );
};

export default GroupSchedule;