db.ecm_objects.createIndex({ objectType: 1, id: 1 }, { unique: true });
db.ecm_objects.createIndex({ parentId: 1 });
