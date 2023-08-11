## incomes Table

|Column             |Type       |Options          | 
|------             |----       |-------          |
|income_amount      |integer    |null: false      |
|date               |date       |null: false      |
|category_id        |integer    |null: false      |

### Association

belongs_to report


## expenses Table

|Column             |Type       |Options          |
|------             |----       |-------          |
|expenses_amount    |integer    |null: false      |
|date               |date       |null: false      |
|category_id        |integer    |null: false      |

### Association

belongs_to report


## reports Table

|Column             |Type       |Options          |
|------             |----       |-------          |
|total_income       |integer    |null: false      |
|total_amount       |integer    |null: false      |
|date               |date       |null: false      |

### Association

has_many incomes
has_many expenses
has_many budgets


## budgets Table

|Column             |Type       |Options          |
|------             |----       |-------          |
|budgets_amount     |integer    |null: false      |
|date               |date       |null: false      |

### Association

belongs_to report