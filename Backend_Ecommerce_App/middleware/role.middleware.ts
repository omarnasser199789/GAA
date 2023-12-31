// role.middleware.js
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const roleMiddleware = async (req, res, next) => {
  const userId = req.user.id; // Assuming you have user information in req.user
  const requiredRole = 'admin'; // Change this to the required role

  const user = await prisma.user.findUnique({
    where: { id: userId },
    include: { roles: true },
  });

  if (!user || !user.roles.some(role => role.name === requiredRole)) {
    return res.status(403).json({ message: 'Access denied' });
  }

  next();
};

export default roleMiddleware;
