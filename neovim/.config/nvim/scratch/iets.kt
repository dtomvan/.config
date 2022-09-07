@Query("SELECT * FROM Table WHERE field = 1")
val this = 1

@Query("SELECT * FROM ")
val a = 1

@Query("SELECT ")
val b = 1

@Query("SELECT field,field2 FROM This WHERE this = 1")
val c = 1

@Entity
class This {
  val a = 1
  val this: int
  val that: String
}
