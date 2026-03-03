// api.js - все запросы к бэкенду
import axios from 'axios';

// ========== ГРУППЫ ==========
export const getGroups = () => axios.get('http://localhost:5050/api/groups');
export const createGroup = (data) => axios.post('http://localhost:5050/api/groups', data);
export const deleteGroup = (id) => axios.delete(`http://localhost:5050/api/groups/${id}`);

// ========== ПРЕДМЕТЫ ==========
export const getSubjects = () => axios.get('http://localhost:5050/api/subjects');
export const createSubject = (data) => axios.post('http://localhost:5050/api/subjects', data);
export const deleteSubject = (id) => axios.delete(`http://localhost:5050/api/subjects/${id}`);

// ========== ПРЕПОДАВАТЕЛИ ==========
export const getTeachers = () => axios.get('http://localhost:5050/api/teachers');
export const getTeacherSubjects = (id) => axios.get(`http://localhost:5050/api/teachers/${id}/subjects`);
export const createTeacher = (data) => axios.post('http://localhost:5050/api/teachers', data);

// ========== РАСПИСАНИЕ ==========
export const getAllSchedules = () => axios.get('http://localhost:5050/api/schedule');
export const getGroupSchedule = (groupName, week = 'all') => 
    axios.get(`http://localhost:5050/api/schedule/${groupName}?week=${week}`);
export const getTeacherSchedule = (teacherId) => 
    axios.get(`http://localhost:5050/api/schedule/teacher/${teacherId}`);
export const createSchedule = (data) => axios.post('http://localhost:5050/api/schedule', data);