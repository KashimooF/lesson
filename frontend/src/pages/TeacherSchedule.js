import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { getTeacherSchedule } from '../services/api';

const TeacherSchedule = () => {
  const { id } = useParams(); // Получаем ID преподавателя из URL
  const [schedule, setSchedule] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  // Загружаем расписание преподавателя
  useEffect(() => {
    loadSchedule();
  }, [id]);

  const loadSchedule = async () => {
    try {
      const response = await getTeacherSchedule(id);
      setSchedule(response.data);
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
      <h2>Расписание преподавателя</h2>
      
      {/* Если есть занятия */}
      {schedule.length > 0 ? (
        <table className="table">
          <thead>
            <tr>
              <th>Группа</th>
              <th>Предмет</th>
              <th>День</th>
              <th>Пара</th>
              <th>Неделя</th>
            </tr>
          </thead>
          <tbody>
            {schedule.map(item => (
              <tr key={item.ID}>
                <td>{item.NameGroup}</td>
                <td>{item.NameSubjects}</td>
                <td>{daysOfWeek[item.DaysOfWeek - 1]}</td>
                <td>{item.NumberPar}</td>
                <td>{weekTypes[item.WeekType]}</td>
              </tr>
            ))}
          </tbody>
        </table>
      ) : (
        // Если занятий нет
        <p style={{ textAlign: 'center', marginTop: '2rem' }}>
          У преподавателя нет занятий
        </p>
      )}
    </div>
  );
};

export default TeacherSchedule;