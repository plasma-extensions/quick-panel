#ifndef LOOKANDFEELMODEL_H
#define LOOKANDFEELMODEL_H

#include <QList>
#include <QHash>
#include <QVariant>
#include <QByteArray>
#include <QAbstractListModel>

#include <KConfig>
#include <KConfigGroup>
#include <Plasma/Package>
#include <KQuickAddons/ConfigModule>

class LookAndFeelModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int current READ current WRITE setCurrent NOTIFY currentChanged)
public:
    enum Roles {
        Name = Qt::UserRole + 1,
        PluginName,
    };

    explicit LookAndFeelModel(QObject *parent = 0);

    QHash< int, QByteArray > roleNames() const Q_DECL_OVERRIDE;

    int rowCount(const QModelIndex&) const Q_DECL_OVERRIDE;
    QVariant data(const QModelIndex& index, int role) const Q_DECL_OVERRIDE;

    int current();
    void setCurrent(int current);

    void refresh();

    static void setSplashScreen(const QString &theme);
    static void setLockScreen(const QString &theme);
    static void setWindowSwitcher(const QString &theme);
    static void setDesktopSwitcher(const QString &theme);

signals:
    void currentChanged();

private:
    QList<QVariantMap> entries;
};

#endif // LOOKANDFEELMODEL_H
