enum PlanType {
  template,
  program
}

abstract class Plan {
  PlanType get planType;
}