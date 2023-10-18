class TableData {
  static final Map<String, int> _weights = {
    'EDM01': 5,
    'EDM02': 5,
    'EDM03': 5,
    'EDM04': 5,
    'EDM05': 5,
    'APO01': 3,
    'APO02': 3,
    'APO03': 2,
    'APO04': 1,
    'APO05': 3,
    'APO06': 3,
    'APO07': 4,
    'APO08': 5,
    'APO09': 5,
    'APO10': 5,
    'APO11': 5,
    'APO12': 4,
    'APO13': 5,
    'APO14': 4,
    'BAI01': 4,
    'BAI02': 4,
    'BAI03': 4,
    'BAI04': 3,
    'BAI05': 3,
    'BAI06': 3,
    'BAI07': 2,
    'BAI08': 2,
    'BAI09': 3,
    'BAI10': 3,
    'BAI11': 3,
    'DSS01': 4,
    'DSS02': 3,
    'DSS03': 3,
    'DSS04': 2,
    'DSS05': 3,
    'DSS06': 5,
    'MEA01': 4,
    'MEA02': 3,
    'MEA03': 2,
    'MEA04': 1,
  };

  static final List<String> _objectives = [
    'Ensured governance framework setting and maintenance',
    'Ensured benefits delivery',
    'Ensured risk optimization',
    'Ensured resource optimization',
    'Ensured stakeholder engagement',
    'Managed I&T management framework',
    'Managed strategy',
    'Managed enterprise architecture',
    'Managed innovation',
    'Managed portfolio',
    'Managed budget and costs',
    'Managed human resources',
    'Managed relationships',
    'Managed service agreements',
    'Managed vendors',
    'Managed quality',
    'Managed risk',
    'Managed security',
    'Managed data',
    'Managed programs',
    'Managed requirements definition',
    'Managed solutions identification and build',
    'Managed availability and capacity',
    'Managed organizational change',
    'Managed IT changes',
    'Managed IT change acceptance and transitioning',
    'Managed knowledge',
    'Managed assets',
    'Managed configuration',
    'Managed projects',
    'Managed operations',
    'Managed service requests and incidents',
    'Managed problems',
    'Managed continuity',
    'Managed security services',
    'Managed business process controls',
    'Managed performance and conformance monitoring',
    'Managed system of internal control',
    'Managed compliance with external requirements',
    'Managed assurance',
  ];

  static final List<String> _domainCodes = _weights.keys.toList();

  static final List<String> _domains = [
    'Evaluate',
    '',
    '',
    '',
    '',
    'Align',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    'Build',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    'Deliver',
    '',
    '',
    '',
    '',
    '',
    'Monitor',
    '',
    '',
    '',
  ];

  // Getters to access the data
  static Map<String, int> get weights => Map.unmodifiable(_weights);
  static List<String> get objectives => List.unmodifiable(_objectives);
  static List<String> get domains => List.unmodifiable(_domains);
  static List<String> get domainCodes => List.unmodifiable(_domainCodes);

  // Calculate scores based on audit data
  static List<int> calculateScores(List<int> audits) {
    // Initialize an empty list to store scores
    List<int> scores = List<int>.filled(40, 0);
    List<int> weightValues = _weights.values.toList();
    if (audits.length == 40) {
      // Calculate scores for each objective based on weights and audit data
      for (int i = 0; i < 40; i++) {
        scores[i] =
            (weightValues[i] * weightValues[i] * audits[i]) + weightValues[i];
      }
    }

    // Calculate total scores for each domain
    List<int> totalDomainScores = List<int>.filled(40, 0);

    totalDomainScores[0] =
        scores.sublist(0, 5).fold(0, (value, element) => value + element);
    totalDomainScores[1] =
        scores.sublist(5, 19).fold(0, (value, element) => value + element);
    totalDomainScores[2] =
        scores.sublist(19, 30).fold(0, (value, element) => value + element);
    totalDomainScores[3] =
        scores.sublist(30, 36).fold(0, (value, element) => value + element);
    totalDomainScores[4] =
        scores.sublist(36, 40).fold(0, (values, element) => values + element);

    return totalDomainScores;
  }

  // Calculate maximum possible scores for each domain
  static List<int> calculateMaxDomainScores() {
    // Initialize an empty list to store maximum scores
    List<int> scores = List<int>.filled(40, 0);
    List<int> weightValues = _weights.values.toList();
    for (int i = 0; i < 40; i++) {
      scores[i] = (weightValues[i] * weightValues[i] * 1 + weightValues[i]);
    }

    // Calculate total maximum scores for each domain
    List<int> maxDomainScores = List<int>.filled(5, 0);

    maxDomainScores[0] =
        scores.sublist(0, 5).fold(0, (value, element) => value + element);
    maxDomainScores[1] =
        scores.sublist(5, 19).fold(0, (value, element) => value + element);
    maxDomainScores[2] =
        scores.sublist(19, 30).fold(0, (value, element) => value + element);
    maxDomainScores[3] =
        scores.sublist(30, 36).fold(0, (value, element) => value + element);
    maxDomainScores[4] =
        scores.sublist(36, 40).fold(0, (values, element) => values + element);

    return maxDomainScores;
  }

  static List<int> calculateDomainScores(List<int> audits) {
    List<int> scores = List<int>.filled(40, 0);
    List<int> weightValues = _weights.values.toList();
    if (audits.length == 40) {
      for (int i = 0; i < 40; i++) {
        scores[i] =
            (weightValues[i] * weightValues[i] * audits[i]) + weightValues[i];
      }
    }

    List<int> totalDomainScores = List<int>.filled(5, 0);

    totalDomainScores[0] =
        scores.sublist(0, 5).fold(0, (value, element) => value + element);

    totalDomainScores[1] =
        scores.sublist(5, 19).fold(0, (value, element) => value + element);

    totalDomainScores[2] =
        scores.sublist(19, 30).fold(0, (value, element) => value + element);

    totalDomainScores[3] =
        scores.sublist(30, 36).fold(0, (value, element) => value + element);

    totalDomainScores[4] =
        scores.sublist(36, 40).fold(0, (values, element) => values + element);

    return totalDomainScores;
  }
}
