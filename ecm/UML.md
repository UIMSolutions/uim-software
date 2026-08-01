# UML

```mermaid
classDiagram
  class SAPController
  class EcmHealthController
  class EcmApiController
  class UiController
  class DocumentApiController
  class ObjectTypeController
  class AuthGuard

  class EcmRepository {
    +listByType(objectType)
    +getByTypeAndId(objectType, id)
    +create(value)
    +update(value)
    +remove(objectType, id)
    +listDocumentVersions(documentId)
  }

  class MemoryEcmRepository
  class PostgresEcmRepository
  class MongoEcmRepository
  class ManageEcmObjectsUseCase
  class QueryDocumentsUseCase
  class EcmObject

  SAPController <|-- EcmHealthController
  SAPController <|-- EcmApiController
  SAPController <|-- UiController
  SAPController <|-- DocumentApiController
  SAPController <|-- ObjectTypeController

  EcmRepository <|.. MemoryEcmRepository
  EcmRepository <|.. PostgresEcmRepository
  EcmRepository <|.. MongoEcmRepository
  ManageEcmObjectsUseCase --> EcmRepository
  QueryDocumentsUseCase --> EcmRepository
  EcmApiController --> ManageEcmObjectsUseCase
  EcmApiController --> QueryDocumentsUseCase
  EcmApiController --> UiController
  EcmApiController --> DocumentApiController
  EcmApiController --> ObjectTypeController
  ObjectTypeController --> AuthGuard
  DocumentApiController --> AuthGuard
  MemoryEcmRepository --> EcmObject
```

```mermaid
flowchart LR
  UI[Web Client] --> API[HTTP Controller]
  API --> UC1[ManageEcmObjectsUseCase]
  API --> UC2[QueryDocumentsUseCase]
  UC1 --> PORT[EcmRepository Port]
  UC2 --> PORT
  PORT --> ADAPTER[MemoryEcmRepository Adapter]
```
