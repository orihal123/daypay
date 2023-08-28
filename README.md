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


## budgets Table

|Column             |Type       |Options          |
|------             |----       |-------          |
|budgets_amount     |integer    |null: false      |
|date               |date       |null: false      |

### Association

belongs_to report

## budgetfifferences Table

|Column             |Type       |Options          |
|------             |----       |-------          |
|budgetfifferences     |integer    |null: false      |
|date               |date       |null: false      |

### Association

b