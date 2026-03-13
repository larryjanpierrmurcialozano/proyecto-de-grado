# Calificaciones    
from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import List
from ..database import get_db
import mysql.connector
