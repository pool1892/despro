/*
 * Gegeben sei eine beliebige Datenbank von Fakten ueber verschiedene Punkte und (echte)
 * Strecken in der Ebene, etwa:
 */
line(a, b). line(c, b). line(d, a).
line(b, d). line(d, c). line(d, e).
/*
 * Implementieren Sie drei- bzw. vierstellige Praedikate "triangle" und
 * "tetragon" fuer mittels der gegebenen Strecken gebildete (echte) Drei- und
 * Vierecke. Eine Strecke bzw. ein Drei- oder Viereck heissen "echt" wenn
 * jeweils keine zwei der aufgefuehrten Punkte gleich sind.
 *
 * Beachten Sie ausserdem, dass die obige "line"-Relation nicht symmetrisch ist,
 * Verbindungen zwischen Punkten aber natuerlich konzeptionell doch.
 */
